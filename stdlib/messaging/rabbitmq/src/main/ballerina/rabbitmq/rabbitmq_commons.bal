// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

# Types of exchanges supported by the Ballerina RabbitMQ Connector.
public type ExchangeType "direct"|"fanout"|"topic"|"headers";

# Constant for the RabbitMQ Direct Exchange type.
public const DIRECT_EXCHANGE = "direct";

# Constant for the RabbitMQ Fanout Exchange type.
public const FANOUT_EXCHANGE = "fanout";

# Constant for the RabbitMQ Topic Exchange type.
public const TOPIC_EXCHANGE = "topic";

# Types of acknowledgement modes supported by the Ballerina RabbitMQ Connector.
public type AcknowledgementMode AUTO_ACK | CLIENT_ACK;

# Constant for the RabbitMQ auto acknowledgement mode.
public const AUTO_ACK = "auto";

# Constant for the RabbitMQ client acknowledgement mode.
public const CLIENT_ACK = "client";

# RabbitMQ Error code.
public const string RABBITMQ_ERROR_CODE = "{ballerina/RabbitMQ}RabbitMQError";

# RabbitMQ Error record.
#
# + message - Error message.
type RabbitMQError record {|
    string message;
|};

# Holds other properties of the message - routing headers etc.
#
# + replyTo - The queue name to which the other apps should send the response.
# + contentType - Content type of the message.
# + contentEncoding - Content encoding of the message.
# + correlationId - Client-specific ID that can be used to mark or identify messages between clients.
public type BasicProperties record {|
    string? replyTo;
    string? contentType;
    string? contentEncoding;
    string? correlationId;
|};

# Holds the parameters used to declare a queue.
#
# + queueName - The name of the queue, which will be autogenerated if not specified.
# + durable - True if declaring a durable queue (the queue will survive in a server restart).
# + exclusive - True if declaring an exclusive queue (restricted to this connection).
# + autoDelete - True if declaring an autodelete queue (the server will delete it when it is no longer in use).
# + arguments - Other properties (construction arguments) for the queue.
public type QueueConfiguration record {|
    string queueName;
    boolean durable = false;
    boolean exclusive = false;
    boolean autoDelete = true;
    map<any>? arguments = ();
|};

# Holds the parameters used to declare an exchange.
#
# + exchangeName - The name of the exchange.
# + exchangeType - The type of exchange.
# + durable - True if declaring a durable exchange (the exchange will survive a server restart).
# + autoDelete - True if we are declaring an autodelete exchange (server will delete it when it is no longer in use).
# + arguments - Other properties (construction arguments) for the queue.
public type ExchangeConfiguration record {|
    string exchangeName;
    ExchangeType exchangeType = DIRECT_EXCHANGE;
    boolean durable = false;
    boolean autoDelete = false;
    map<any>? arguments = ();
|};

# Holds the parameters used to create a RabbitMQ `Connection`.
#
# + host - The host used for establishing the connection.
# + port - The port used for establishing the connection.
# + username - The username used for establishing the connection.
# + password - The password used for establishing the connection.
# + connectionTimeout - Connection TCP establishment timeout in milliseconds; zero for infinite.
# + handshakeTimeout -  The AMQP 0-9-1 protocol handshake timeout in milliseconds.
# + shutdownTimeout - Shutdown timeout in milliseconds; zero for infinite; default 10000. If consumers exceed
#                     this timeout then any remaining queued deliveries (and other Consumer callbacks) will be lost.
# + heartbeat - The initially requested heartbeat timeout in seconds; zero for none.
public type ConnectionConfiguration record {|
    string host;
    int port = 5672;
    string? username = ();
    string? password = ();
    int? connectionTimeout = ();
    int? handshakeTimeout = ();
    int? shutdownTimeout = ();
    int? heartbeat = ();
|};
