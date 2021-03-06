require 'spec_helper'

describe Mongo::Cluster do

  let(:monitoring) do
    Mongo::Monitoring.new(monitoring: false)
  end

  let(:cluster) do
    described_class.new(SpecConfig.instance.addresses, monitoring, TEST_OPTIONS)
  end

  describe '#==' do

    context 'when the other is a cluster' do

      context 'when the addresses are the same' do

        context 'when the options are the same' do

          let(:other) do
            described_class.new(SpecConfig.instance.addresses, monitoring, TEST_OPTIONS)
          end

          it 'returns true' do
            expect(cluster).to eq(other)
          end
        end

        context 'when the options are not the same' do

          let(:other) do
            described_class.new([ '127.0.0.1:27017' ], monitoring, TEST_OPTIONS.merge(:replica_set => 'test'))
          end

          it 'returns false' do
            expect(cluster).to_not eq(other)
          end
        end
      end

      context 'when the addresses are not the same' do

        let(:other) do
          described_class.new([ '127.0.0.1:27018' ], monitoring, TEST_OPTIONS)
        end

        it 'returns false' do
          expect(cluster).to_not eq(other)
        end
      end
    end

    context 'when the other is not a cluster' do

      it 'returns false' do
        expect(cluster).to_not eq('test')
      end
    end
  end

  describe '#has_readable_server?' do

    let(:selector) do
      Mongo::ServerSelector.get(mode: :primary)
    end

    it 'delegates to the topology' do
      expect(cluster.has_readable_server?).to eq(cluster.topology.has_readable_server?(cluster))
    end
  end

  describe '#has_writable_server?' do

    it 'delegates to the topology' do
      expect(cluster.has_writable_server?).to eq(cluster.topology.has_writable_server?(cluster))
    end
  end

  describe '#inspect' do

    let(:preference) do
      Mongo::ServerSelector.get(ServerSelector::PRIMARY)
    end

    it 'displays the cluster seeds and topology' do
      expect(cluster.inspect).to include('topology')
      expect(cluster.inspect).to include('servers')
    end
  end

  describe '#replica_set_name' do

    let(:preference) do
      Mongo::ServerSelector.get(ServerSelector::PRIMARY)
    end

    context 'when the option is provided' do

      let(:cluster) do
        described_class.new(
          [ '127.0.0.1:27017' ],
          monitoring,
          TEST_OPTIONS.merge(:connect => :replica_set, :replica_set => 'testing')
        )
      end

      it 'returns the name' do
        expect(cluster.replica_set_name).to eq('testing')
      end
    end

    context 'when the option is not provided' do

      let(:cluster) do
        described_class.new([ '127.0.0.1:27017' ], monitoring, TEST_OPTIONS.merge(connect: :direct).delete_if { |k| k == :replica_set })
      end

      it 'returns nil' do
        expect(cluster.replica_set_name).to be_nil
      end
    end
  end

  describe '#scan!' do

    let(:preference) do
      Mongo::ServerSelector.get(ServerSelector::PRIMARY)
    end

    let(:known_servers) do
      cluster.instance_variable_get(:@servers)
    end

    before do
      expect(known_servers.first).to receive(:scan!).and_call_original
    end

    it 'returns true' do
      expect(cluster.scan!).to be true
    end
  end

  describe '#servers' do

    context 'when topology is single', if: single_seed? do

      context 'when the server is a mongos', if: single_mongos?  do

        it 'returns the mongos' do
          expect(cluster.servers.size).to eq(1)
        end
      end

      context 'when the server is a replica set member', if: single_rs_member? do

        it 'returns the replica set member' do
          expect(cluster.servers.size).to eq(1)
        end
      end
    end

    context 'when the cluster has no servers' do

      let(:servers) do
        [nil]
      end

      before do
        cluster.instance_variable_set(:@servers, servers)
        cluster.instance_variable_set(:@topology, topology)
      end

      context 'when topology is Single' do

        let(:topology) do
          Mongo::Cluster::Topology::Single.new({}, monitoring)
        end

        it 'returns an empty array' do
          expect(cluster.servers).to eq([])
        end
      end

      context 'when topology is ReplicaSet' do

        let(:topology) do
          Mongo::Cluster::Topology::ReplicaSet.new({}, monitoring)
        end

        it 'returns an empty array' do
          expect(cluster.servers).to eq([])
        end
      end

      context 'when topology is Sharded' do

        let(:topology) do
          Mongo::Cluster::Topology::Sharded.new({}, monitoring)
        end

        it 'returns an empty array' do
          expect(cluster.servers).to eq([])
        end
      end

      context 'when topology is Unknown' do

        let(:topology) do
          Mongo::Cluster::Topology::Unknown.new({}, monitoring)
        end

        it 'returns an empty array' do
          expect(cluster.servers).to eq([])
        end
      end
    end
  end

  describe '#add' do

    context 'when topology is Single' do

      let(:topology) do
        Mongo::Cluster::Topology::Single.new({})
      end

      before do
        cluster.add('a')
      end

      it 'does not add discovered servers to the cluster' do
        expect(cluster.servers[0].address.seed).to_not eq('a')
      end
    end
  end

  describe '#disconnect!' do

    let(:known_servers) do
      cluster.instance_variable_get(:@servers)
    end

    let(:periodic_executor) do
      cluster.instance_variable_get(:@periodic_executor)
    end

    before do
      known_servers.each do |server|
        expect(server).to receive(:disconnect!).and_call_original
      end
      expect(periodic_executor).to receive(:stop!).and_call_original
    end

    it 'disconnects each server and the cursor reaper and returns true' do
      expect(cluster.disconnect!).to be(true)
    end
  end

  describe '#reconnect!' do

    let(:periodic_executor) do
      cluster.instance_variable_get(:@periodic_executor)
    end

    before do
      cluster.servers.each do |server|
        expect(server).to receive(:reconnect!).and_call_original
      end
      expect(periodic_executor).to receive(:restart!).and_call_original
    end

    it 'reconnects each server and the cursor reaper and returns true' do
      expect(cluster.reconnect!).to be(true)
    end
  end

  describe '#remove' do

    let(:address_a) do
      Mongo::Address.new('127.0.0.1:27017')
    end

    let(:address_b) do
      Mongo::Address.new('127.0.0.1:27018')
    end

    let(:monitoring) do
      Mongo::Monitoring.new(monitoring: false)
    end

    let(:server_a) do
      Mongo::Server.new(address_a, cluster, monitoring, Mongo::Event::Listeners.new)
    end

    let(:server_b) do
      Mongo::Server.new(address_b, cluster, monitoring, Mongo::Event::Listeners.new)
    end

    let(:servers) do
      [ server_a, server_b ]
    end

    let(:addresses) do
      [ address_a, address_b ]
    end

    before do
      cluster.instance_variable_set(:@servers, servers)
      cluster.instance_variable_set(:@addresses, addresses)
      cluster.remove('127.0.0.1:27017')
    end

    it 'removes the host from the list of servers' do
      expect(cluster.instance_variable_get(:@servers)).to eq([server_b])
    end

    it 'removes the host from the list of addresses' do
      expect(cluster.instance_variable_get(:@addresses)).to eq([address_b])
    end
  end

  describe '#add_hosts' do

    let(:servers) do
      [nil]
    end

    let(:hosts) do
      ["127.0.0.1:27018"]
    end

    let(:description) do
      Mongo::Server::Description.new(double('address'), { 'hosts' => hosts })
    end

    before do
      cluster.instance_variable_set(:@servers, servers)
      cluster.instance_variable_set(:@topology, topology)
    end

    context 'when the topology allows servers to be added' do

      let(:topology) do
        double('topology').tap do |t|
          allow(t).to receive(:add_hosts?).and_return(true)
        end
      end

      it 'adds the servers' do
        expect(cluster).to receive(:add).once
        cluster.add_hosts(description)
      end
    end

    context 'when the topology does not allow servers to be added' do

      let(:topology) do
        double('topology').tap do |t|
          allow(t).to receive(:add_hosts?).and_return(false)
        end
      end

      it 'does not add the servers' do
        expect(cluster).not_to receive(:add)
        cluster.add_hosts(description)
      end
    end
  end

  describe '#remove_hosts' do

    let(:listeners) do
      Mongo::Event::Listeners.new
    end

    let(:address) do
      Mongo::Address.new('127.0.0.1:27017')
    end

    let(:monitoring) do
      Mongo::Monitoring.new(monitoring: false)
    end

    let(:server) do
      Mongo::Server.new(address, cluster, monitoring, listeners)
    end

    let(:servers) do
      [ server ]
    end

    let(:hosts) do
      ["127.0.0.1:27018"]
    end

    let(:description) do
      Mongo::Server::Description.new(double('address'), { 'hosts' => hosts })
    end

    context 'when the topology allows servers to be removed' do

      context 'when the topology allows a specific server to be removed' do

        let(:topology) do
          double('topology').tap do |t|
            allow(t).to receive(:remove_hosts?).and_return(true)
            allow(t).to receive(:remove_server?).and_return(true)
          end
        end

        before do
          cluster.instance_variable_set(:@servers, servers)
          cluster.instance_variable_set(:@topology, topology)
        end

        it 'removes the servers' do
          expect(cluster).to receive(:remove).once
          cluster.remove_hosts(description)
        end
      end

      context 'when the topology does not allow a specific server to be removed' do

        let(:topology) do
          double('topology').tap do |t|
            allow(t).to receive(:remove_hosts?).and_return(true)
            allow(t).to receive(:remove_server?).and_return(false)
          end
        end

        before do
          cluster.instance_variable_set(:@servers, servers)
          cluster.instance_variable_set(:@topology, topology)
        end

        it 'removes the servers' do
          expect(cluster).not_to receive(:remove)
          cluster.remove_hosts(description)
        end
      end
    end

    context 'when the topology does not allow servers to be removed' do

      let(:topology) do
        double('topology').tap do |t|
          allow(t).to receive(:remove_hosts?).and_return(false)
        end
      end

      before do
        cluster.instance_variable_set(:@servers, servers)
        cluster.instance_variable_set(:@topology, topology)
      end

      it 'does not remove the servers' do
        expect(cluster).not_to receive(:remove)
        cluster.remove_hosts(description)
      end
    end
  end

  describe '#next_primary' do

    let(:cluster) do
      authorized_client.cluster
    end

    let(:primary_candidates) do
      if cluster.single?
        cluster.servers
      elsif cluster.sharded?
        cluster.servers
      else
        cluster.servers.select { |s| s.primary? }
      end
    end

    it 'always returns the primary, mongos, or standalone' do
      expect(primary_candidates).to include(cluster.next_primary)
    end
  end

  describe '#app_metadata' do

    it 'returns an AppMetadata object' do
      expect(cluster.app_metadata).to be_a(Mongo::Cluster::AppMetadata)
    end

    context 'when the client has an app_name set' do

      let(:cluster) do
        authorized_client.with(app_name: 'cluster_test').cluster
      end

      it 'constructs an AppMetadata object with the app_name' do
        expect(cluster.app_metadata.send(:full_client_document)[:application]).to eq('name' => 'cluster_test')
      end
    end

    context 'when the client does not have an app_name set' do

      let(:cluster) do
        authorized_client.cluster
      end

      it 'constructs an AppMetadata object with no app_name' do
        expect(cluster.app_metadata.send(:full_client_document)[:application]).to be_nil
      end
    end
  end

  describe '#logical_session_timeout' do

    let(:listeners) do
      Mongo::Event::Listeners.new
    end

    let(:monitoring) do
      Mongo::Monitoring.new(monitoring: false)
    end

    let(:server_one) do
      Mongo::Server.new(default_address, cluster, monitoring, listeners)
    end

    let(:server_two) do
      Mongo::Server.new(default_address, cluster, monitoring, listeners)
    end

    let(:servers) do
      [ server_one, server_two ]
    end

    before do
      allow(cluster).to receive(:servers).and_return(servers)
    end

    context 'when one server has a nil logical session timeout value' do

      before do
        allow(server_one).to receive(:logical_session_timeout).and_return(7)
        allow(server_two).to receive(:logical_session_timeout).and_return(nil)
      end

      it 'returns nil' do
        expect(cluster.logical_session_timeout).to be(nil)
      end
    end

    context 'when all servers have a logical session timeout value' do

      before do
        allow(server_one).to receive(:logical_session_timeout).and_return(7)
        allow(server_two).to receive(:logical_session_timeout).and_return(3)
      end

      it 'returns the minimum' do
        expect(cluster.logical_session_timeout).to be(3)
      end
    end

    context 'when no servers have a logical session timeout value' do

      before do
        allow(server_one).to receive(:logical_session_timeout).and_return(nil)
        allow(server_two).to receive(:logical_session_timeout).and_return(nil)
      end

      it 'returns nil' do
        expect(cluster.logical_session_timeout).to be(nil)
      end
    end
  end

  describe '#cluster_time' do

    let(:operation) do
      client.command(ping: 1)
    end

    let(:operation_with_session) do
      client.command({ ping: 1 }, session: session)
    end

    let(:second_operation) do
      client.command({ ping: 1 }, session: session)
    end

    it_behaves_like 'an operation updating cluster time'
  end

  describe '#update_cluster_time' do

    let(:cluster) do
      described_class.new(SpecConfig.instance.addresses, monitoring, TEST_OPTIONS.merge(heartbeat_frequency: 1000))
    end

    let(:result) do
      double('result', cluster_time: cluster_time_doc)
    end

    context 'when the cluster_time variable is nil' do

      before do
        cluster.instance_variable_set(:@cluster_time, nil)
        cluster.update_cluster_time(result)
      end

      context 'when the cluster time received is nil' do

        let(:cluster_time_doc) do
          nil
        end

        it 'does not set the cluster_time variable' do
          expect(cluster.cluster_time).to be_nil
        end
      end

      context 'when the cluster time received is not nil' do

        let(:cluster_time_doc) do
          BSON::Document.new(Mongo::Cluster::CLUSTER_TIME => BSON::Timestamp.new(1, 1))
        end

        it 'sets the cluster_time variable to the cluster time doc' do
          expect(cluster.cluster_time).to eq(cluster_time_doc)
        end
      end
    end

    context 'when the cluster_time variable has a value' do

      before do
        cluster.instance_variable_set(:@cluster_time, BSON::Document.new(
            Mongo::Cluster::CLUSTER_TIME => BSON::Timestamp.new(1, 1)))
        cluster.update_cluster_time(result)
      end

      context 'when the cluster time received is nil' do

        let(:cluster_time_doc) do
          nil
        end

        it 'does not update the cluster_time variable' do
          expect(cluster.cluster_time).to eq(BSON::Document.new(
              Mongo::Cluster::CLUSTER_TIME => BSON::Timestamp.new(1, 1)))
        end
      end

      context 'when the cluster time received is not nil' do

        context 'when the cluster time received is greater than the cluster_time variable' do

          let(:cluster_time_doc) do
            BSON::Document.new(Mongo::Cluster::CLUSTER_TIME => BSON::Timestamp.new(1, 2))
          end

          it 'sets the cluster_time variable to the cluster time' do
            expect(cluster.cluster_time).to eq(cluster_time_doc)
          end
        end

        context 'when the cluster time received is less than the cluster_time variable' do

          let(:cluster_time_doc) do
            BSON::Document.new(Mongo::Cluster::CLUSTER_TIME => BSON::Timestamp.new(0, 1))
          end

          it 'does not set the cluster_time variable to the cluster time' do
            expect(cluster.cluster_time).to eq(BSON::Document.new(
                Mongo::Cluster::CLUSTER_TIME => BSON::Timestamp.new(1, 1)))
          end
        end

        context 'when the cluster time received is equal to the cluster_time variable' do

          let(:cluster_time_doc) do
            BSON::Document.new(Mongo::Cluster::CLUSTER_TIME => BSON::Timestamp.new(1, 1))
          end

          it 'does not change the cluster_time variable' do
            expect(cluster.cluster_time).to eq(BSON::Document.new(
                Mongo::Cluster::CLUSTER_TIME => BSON::Timestamp.new(1, 1)))
          end
        end
      end
    end
  end
end
