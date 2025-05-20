# https://www.elastic.co/docs/reference/elasticsearch/configuration-reference
resource "elasticstack_elasticsearch_cluster_settings" "cluster_settings" {
  persistent {
    setting {
      name  = "cluster.routing.allocation.enable"
      value = "all"
      #value = "primaries"
    }
    setting {
      name  = "cluster.routing.allocation.same_shard.host"
      value = "true"
    }
    setting {
      name  = "cluster.routing.allocation.awareness.attributes"
      value = "zone"
    }
    setting {
      name       = "cluster.routing.allocation.include.zone"
      value_list = ["dc1", "dc2", "aws"]
    }
    #setting {
    #  name       = "cluster.routing.allocation.awareness.force.zone.values"
    #  value_list = ["dc1", "dc2"]
    #}
  }
}
