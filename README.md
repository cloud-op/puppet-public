# puppet-public

.
├── environments
│ └── production
│     ├── data
│     ├── environment.conf
│     ├── hiera.yaml
│     ├── manifests
│     │ └── site.pp
│     └── modules
│         └── cloud
│             ├── files
│             │ ├── check.sh
│             │ ├── jdk-8u211-linux-x64.rpm
│             │ ├── limits.conf
│             │ ├── node_exporter
│             │ ├── node_exporter.service
│             │ ├── ntp.conf
│             │ ├── rename.sh
│             │ └── resolv.conf
│             └── manifests
│                 ├── check.pp
│                 ├── hosts.pp
│                 ├── jdk.pp
│                 ├── limits.pp
│                 ├── monitor.pp
│                 ├── node_exporter.pp
│                 ├── ntp.pp
│                 ├── rename.pp
│                 ├── resolv.pp
│                 ├── service.pp
│                 └── yum.pp
