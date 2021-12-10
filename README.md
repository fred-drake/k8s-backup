# Kubernetes Backup

## Synopsis
Every holistic backup system does one thing that I want, 20 things that I don't, and the complexity ultimately breaks over time.  So I set up my own
simple solution that uses restic to back up my persistent data.

## Supported Types
It currently supports persistent volume claims, postgresql database dumps, and prometheus snapshots.  Why not more?  Because I haven't needed it to.

## How it works
I run a backup instance per namespace, and it attaches to the necessary volume claims in that namespace.  Note that to attach to the same ReadWriteOnce
claims, the backup instance needs to run on the same node as the server that uses these claims.

To see how I use it, look through several of the applications in my [GitOps repository](https://github.com/fred-drake/infrastructure/tree/master/cluster/apps).
I created my own [helm chart](https://github.com/fred-drake/infrastructure/tree/master/cluster/base/charts/backup) for it and add them as dependencies 
to my ArgoCD helm charts.  You can look at the values.yaml file in there for documentation on how to use the variables.
