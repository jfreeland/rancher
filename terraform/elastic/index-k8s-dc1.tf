resource "elasticstack_elasticsearch_index_lifecycle" "k8s_dc1" {
  name = "k8s-dc1"

  hot {
    min_age = "1h"
    set_priority {
      priority = 10
    }
    rollover {
      max_age = "2h"
    }
    readonly {}
  }

  delete {
    min_age = "3h"
    delete {}
  }
}

resource "elasticstack_elasticsearch_index_template" "k8s_dc1" {
  name = "k8s-dc1"

  index_patterns = ["k8s-dc1*"]

  template {
    alias {
      name = "k8s-dc1-log"
    }

    settings = jsonencode({
      index = {
        number_of_shards   = 1
        number_of_replicas = 1
      }
      routing = {
        allocation = {
          include = {
            zone = "dc1"
          }
        }
      }
      "lifecycle.name" = elasticstack_elasticsearch_index_lifecycle.k8s_dc1.name
    })

    mappings = jsonencode({
      properties = {
        "@timestamp" = {
          type = "date"
        }
      }
    })
  }

  data_stream {}

  depends_on = [elasticstack_elasticsearch_cluster_settings.cluster_settings]
}

resource "elasticstack_elasticsearch_data_stream" "k8s_dc1" {
  name = "k8s-dc1"

  depends_on = [elasticstack_elasticsearch_index_template.k8s_dc1]
}
