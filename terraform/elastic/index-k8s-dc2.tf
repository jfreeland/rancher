resource "elasticstack_elasticsearch_index_lifecycle" "k8s_dc2" {
  name = "k8s-dc2"

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
    wait_for_snapshot {
      policy = elasticstack_elasticsearch_snapshot_lifecycle.k8s_dc2.name
    }
    delete {}
  }
}

resource "elasticstack_elasticsearch_index_template" "k8s_dc2" {
  name = "k8s-dc2"

  index_patterns = ["k8s-dc2*"]

  template {
    # TODO: I'm not sure why I need this but it's required for snapshots to work???
    alias {
      name = "k8s-dc2-log"
    }

    settings = jsonencode({
      index = {
        number_of_shards   = 1
        number_of_replicas = 1
      }
      "lifecycle.name" = elasticstack_elasticsearch_index_lifecycle.k8s_dc2.name
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

resource "elasticstack_elasticsearch_data_stream" "k8s_dc2" {
  name = "k8s-dc2"

  depends_on = [elasticstack_elasticsearch_index_template.k8s_dc2]
}
