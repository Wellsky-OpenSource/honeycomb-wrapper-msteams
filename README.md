# honeycomb-wrapper-msteams
Repository Holding the code for Cloud Function to act as a wrapper for Webhook based MS Teams Alerting System for Honeycomb using Google Cloud

## Introduction

1. The Honeycomb Wrapper is designed to push notifications from Honeycomb UI to Microsoft Teams Channel
2. The only input required by the Wrapper is the URL for the incoming webhook to the teams channel [For Details on how to achieve that  refer to [Official Documentation](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook) ]
3. The Wrapper is a Python code which accepts POST requests and parses all the data sent into [MS Teams Compatible JSON format](https://docs.microsoft.com/en-us/microsoftteams/platform/task-modules-and-cards/cards/cards-reference#office-365-connector-card) and makes a Request using the URL provided for the channel

<br>

## TL;DR;

    terraform init
    terraform plan
    terraform apply --auto-approve
    
## Prerequisites
```bash
1. Gcloud SDK
2. terraform 0.12+ 
```
## Steps to deploy 

1. Modify the `variables.tf` file for the value of URL variable under environment_variables this is the URL for the incoming webhook for the MS teams channel along with the project_id which is the Project ID in GCP where the cloud Function will be deployed
2. To Deploy the Wrapper onto any GCP project run the below Commands
    ``` 
    terraform init
    terraform plan
    ```
3. The Terraform Plan will showcase that it will create a Cloud Function in your desired GCP account along with a GCP Bucket
4. After confirming the plan run the below command to create the Cloud Function
    ``` 
    terraform apply --auto-approve
    ```

## Verification

1. Once the Function is created it can be verified using [Postman Application](https://www.postman.com/downloads/) by sending in a Post Request to the HTTP trigger URL
2. Use the below JSON as the request body for Post Request of Successful Notification to the teams channel 
```
{
  "version": "v0.1.0",
  "id": "abdcefg",
  "name": "trig on ttt",
  "trigger_description": "To troubleshoot, please look up the steps in our runbook",
  "trigger_url": "https://ui.honeycomb.io/team/datasets/dataset/triggers/abdcefg",
  "status": "TRIGGERED",
  "summary": "Triggered: trig on ttt",
  "description": "Currently greater than threshold value (2) for foo:fooOOOddd (value 5)",
  "operator": "greater than",
  "threshold": 2,
  "result_url": "",
  "result_groups": [
    {
      "Group": { "foo": "fooOOOddd" },
      "Result": 5
    },
    {
      "Group": { "foo": "hungry" },
      "Result": 1
    },
    {
      "Group": { "foo": "chompy" },
      "Result": 1
    }
  ],
  "result_groups_triggered": [
    {
      "Group": { "foo": "fooOOOddd" },
      "Result": 5
    }
  ]
}
```
3. The output for the above request body is as follows :
```
{
    "result": "Successfully Sent the Notification to MS Teams Channel"
}
```
4. If in case the JSON body is incorrect the Cloud Function returns the below Response
```
{
  "result": "Invalid JSON input kindly correct the Input as per MS-Teams Format"
}

```
5. And in case of incorrect or non active webhook is confgured in the Cloud Function the output is as below:
```
{
    "result": "Trigger to Application Failed Kindly Check Teams Channel URL"
}
```

## Contribute

- Fork it
- Create your feature branch (git checkout -b my-new-feature)
- Commit your changes (git commit -m 'Add some feature')
- Push to the branch (git push origin my-new-feature)
- Create new Pull Request