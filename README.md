# Blue Green Deploy on Kubernetes

## Introduction

One of the challenges with automating deployment is the cut-over itself, taking software from the final stage of testing to live production. You usually need to do this quickly in order to minimize downtime. The blue-green deployment approach does this by ensuring you have two production environments, as identical as possible. At any time one of them, let's say blue for the example, is live. As you prepare a new release of your software you do your final stage of testing in the green environment. Once the software is working in the green environment, you switch the router so that all incoming requests go to the green environment - the blue one is now idle. 

Blue-green deployment also gives you a rapid way to rollback - if anything goes wrong you switch the router back to your blue environment. 

_**Note**_ : There should be an existing version of the application deployed in blue zone so that newer version of the application can be deployed in the green zone and we can make the service point to the green zone deployment.

![](./images/blue_green_deployments.png)


## Installing the Task

```
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/blue-green-deploy/blue-green-deploy-k8s.yaml
```

## Installing ClusterRoleBinding
```
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/blue-green-deploy/clusterrolebinding.yaml
```

## Workspaces

* **manifest-dir**: Deployment file mounted via `ConfigMap` can be provided via the workspaces and the name of the file mounted in the workspace is provided in the _MANIFEST_ params. (Default: _emptyDir:{}_)

## Parameters

* **SERVICE_NAME**: The service name pointing to the existing deployment. (_Note_: The service name for the new deployment should be same)
* **NEW_VERSION**: The version of the deployment to be deployed in the green/blue zone
* **MANIFEST**: The deployment manifest file name/path to be rolled out.

## Usage

This TaskRun runs the Task to deploy the given Kubernetes resource in the green/blue zone and toggle the service to point to the new zone.

```
apiVersion: tekton.dev/v1beta1
kind: TaskRun
metadata:
  name: blue-green-deploy-run
spec:
  taskRef:
    name: blue-green-deploy-k8s
  params:
    - name: SERVICE_NAME
      value: myapp
    - name: NEW_VERSION
      value: v2
    - name: MANIFEST
      value: "https://raw.githubusercontent.com/vinamra28/blue-green-deployment-k8s/master/deployment%2Bservice/blue-deployment.yaml"
  workspaces:
    - name: manifest-dir
      emptyDir: {}
```