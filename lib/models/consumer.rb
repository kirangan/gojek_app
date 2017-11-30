require 'bundler/setup'
require 'rdkafka'

config = {
          :"bootstrap.servers" => "velomobile-01.srvs.cloudkafka.com:9094, velomobile-02.srvs.cloudkafka.com:9094, velomobile-03.srvs.cloudkafka.com:9094",
          :"group.id"          => "5jo12xr9-default",
          :"sasl.username"     => "5jo12xr9",
          :"sasl.password"     => "88E7crAvTmRujqokZeEhxXH-bBOahQ_y",
          :"security.protocol" => "SASL_SSL",
          :"sasl.mechanisms"   => "SCRAM-SHA-256"
}
topic = "5jo12xr9-default"

rdkafka = Rdkafka::Config.new(config)
consumer = rdkafka.consumer
consumer.subscribe(topic)

begin
  consumer.each do |message|
    puts "Message received: #{message}"
  end
rescue Rdkafka::RdkafkaError => e
  retry if e.is_partition_eof?
  raise
end