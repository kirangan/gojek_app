# require 'bundler/setup'
# require 'rdkafka'


# config = {
#           :"bootstrap.servers" => "velomobile-01.srvs.cloudkafka.com:9094, velomobile-02.srvs.cloudkafka.com:9094, velomobile-03.srvs.cloudkafka.com:9094",
#           :"group.id"          => "5jo12xr9-default",
#           :"sasl.username"     => "5jo12xr9",
#           :"sasl.password"     => "88E7crAvTmRujqokZeEhxXH-bBOahQ_y",
#           :"security.protocol" => "SASL_SSL",
#           :"sasl.mechanisms"   => "SCRAM-SHA-256"
# }
# topic = "5jo12xr9-default"

# rdkafka = Rdkafka::Config.new(config)
# producer = rdkafka.producer

# # 100.times do |i|
# #   puts "Producing message #{i}"
# #   producer.produce(
# #       topic:   topic,
# #       payload: "Payload #{i}",
# #       key:     "Key #{i}"
# #   ).wait


# end