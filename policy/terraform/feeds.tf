resource "checkpoint_management_network_feed" "feedME" {
  name     = "feed_serv_ip"
  feed_url = "https://feed-serv.deno.dev/ip"
  #   username = "feed_username"
  #   password = "feed_password"
  feed_format     = "JSON"
  feed_type       = "IP Address"
  update_interval = 60
  json_query      = ".[]|.ip"
}

// https://quic.cloud/ips

resource "checkpoint_management_network_feed" "quiccloud" {
  name     = "quic_cloud"
  feed_url = "https://quic.cloud/ips?ln"
  #   username = "feed_username"
  #   password = "feed_password"
  feed_format     = "Flat List"
  feed_type       = "IP Address"
  update_interval = 60
}

# feed_dev_airflow

resource "checkpoint_management_network_feed" "f1" {
  name     = "feed_dev_airflow"
  feed_url = "https://feed-serv.deno.dev/ip"
  #   username = "feed_username"
  #   password = "feed_password"
  feed_format     = "JSON"
  feed_type       = "IP Address"
  update_interval = 60
  json_query      = ".[]|.ip"
}

resource "checkpoint_management_network_feed" "f2" {
  name     = "feed_dev_cicd-jenkins"
  feed_url = "https://feed-serv.deno.dev/ip"
  #   username = "feed_username"
  #   password = "feed_password"
  feed_format     = "JSON"
  feed_type       = "IP Address"
  update_interval = 60
  json_query      = ".[]|.ip"
}

resource "checkpoint_management_network_feed" "f3" {
  name     = "feed_dev_cicd-formule1"
  feed_url = "https://feed-serv.deno.dev/ip"
  #   username = "feed_username"
  #   password = "feed_password"
  feed_format     = "JSON"
  feed_type       = "IP Address"
  update_interval = 60
  json_query      = ".[]|.ip"
}