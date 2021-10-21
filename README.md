# Waypoint Kubernetes Example (using Helm)

|Title|Description|
|---|---|
|Pack|Cloud Native Buildpack|
|Cloud|Any|
|Language|NodeJS|
|Docs|[Kubernetes](https://www.waypointproject.io/plugins/kubernetes)|

This example shows how to deploy an application built with buildpacks
to Kubernetes using a local Helm chart.

### Tools
tools: 
 waypoint 
 helm 
 kubectl
 k9s 

### Install procedure
helm repo add hashicorp https://helm.releases.hashicorp.com

### Init 

`waypoint login -from-kubernetes` - will attach you to current kuber context
`waypoint user token` - will give auth token for session ( looks secure )
`waypoint context verify` - to test connection to waypoint


### ci/cd process 

steps: 
 - Build - A build takes application source and converts it to an artifact, `https://www.waypointproject.io/docs/lifecycle/build`


```
DOcker auth could be enabled with IAM, Username/Password or docker_auth file
```

 - Deploy - A deploy takes a previously built artifact and stages it onto the target deployment platform and is available via deployment URLs or other internal means. `https://www.waypointproject.io/docs/lifecycle/deploy`
 - Release - A release activates a previously staged deployment and opens it to general traffic. `https://www.waypointproject.io/docs/lifecycle/release`


 ### Commands
 ```
  login        Log in to a Waypoint server
  build        Build a new versioned artifact from source
  deploy       Deploy a pushed artifact
  release      Release a deployment
  status       List and refresh application statuses.
  up           Perform the build, deploy, and release steps
```

```
waypoint destroy -auto-approve - destroy all now
waypoint deploy -release=false
```

## CONS
 - can't remove project !!!
 - encoded_auth = filebase64("/Users/igor/Develop/waypoint-app/dockerAuth.json") - olny full path

## PROS
 - integration with HC tools
