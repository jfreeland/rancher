resource "elasticstack_kibana_data_view" "k8s_data_view" {
  data_view = {
    name            = "k8s-*"
    title           = "k8s-*"
    time_field_name = "@timestamp"
  }

  depends_on = [
    elasticstack_elasticsearch_data_stream.k8s_dc1,
    elasticstack_elasticsearch_data_stream.k8s_dc2
  ]
}
