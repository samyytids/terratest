resource "google_bigquery_dataset" "dataset" {
  dataset_id    = "benchmark_config_dataset"
  project       = var.project_id
  friendly_name = "benchmark_config"
  description   = "Dataset for storing benchmark configurations"
  location      = "EU"

  labels = {
    env = "default"
  }

  access {
    role          = "OWNER"
    user_by_email = google_service_account.bqowner.email
  }

  access {
    role   = "READER"
    domain = var.reader_domain
  }
}

resource "google_service_account" "bqowner" {
  account_id = "bqowner"
  project    = var.project_id
}

resource "google_storage_bucket_iam_member" "bq_read" {
  bucket = "benchmar_config"
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.bqowner.email}"
}


resource "google_bigquery_table" "dim_models" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  project    = var.project_id
  table_id   = "dim_models"
  external_data_configuration {
    autodetect    = false
    source_format = "CSV"
    source_uris   = ["gs://benchmar_config/*/models.csv"]
    csv_options {
      quote = var.csv_quote
      skip_leading_rows = var.csv_skip_leading_rows
    }
    hive_partitioning_options {
      mode                     = "AUTO"
      source_uri_prefix        = "gs://benchmar_config/"
      require_partition_filter = true
    }
  }
  schema = file("./dim_models.json")
}

resource "google_bigquery_table" "dim_providers" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  project    = var.project_id
  table_id   = "dim_providers"
  external_data_configuration {
    autodetect    = false
    source_format = "CSV"
    source_uris   = ["gs://benchmar_config/*/providers.csv"]
    csv_options {
      quote = var.csv_quote
      skip_leading_rows = var.csv_skip_leading_rows
    }
    hive_partitioning_options {
      mode                     = "AUTO"
      source_uri_prefix        = "gs://benchmar_config/"
      require_partition_filter = true
    }
  }
  schema = file("./dim_providers.json")
}
