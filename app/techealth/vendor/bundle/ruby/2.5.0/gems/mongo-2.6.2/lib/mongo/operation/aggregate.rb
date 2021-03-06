# Copyright (C) 2015-2018 MongoDB, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'mongo/operation/aggregate/command'
require 'mongo/operation/aggregate/op_msg'
require 'mongo/operation/aggregate/result'

module Mongo
  module Operation
    
    # A MongoDB aggregate operation.
    #
    # @note An aggregate operation can behave like a read and return a
    #   result set, or can behave like a write operation and
    #   output results to a user-specified collection.
    #
    # @api private
    #
    # @since 2.0.0
    class Aggregate
      include Specifiable

      # Execute the operation.
      # 
      # @example
      #   operation.execute(server)
      # 
      # @param [ Mongo::Server ] server The server to send the operation to.
      # 
      # @return [ Mongo::Operation::Aggregate::Result ] The operation result.
      # 
      # @since 2.0.0
      def execute(server)
        if server.features.op_msg_enabled?
          OpMsg.new(spec).execute(server)
        else
          Command.new(spec).execute(server)
        end
      end
    end
  end
end
