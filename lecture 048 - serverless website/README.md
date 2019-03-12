# Serverless Notes App
An app hosted in S3 which allows users to upload a typed note, and receive an MP3 of upload notes file.

## Steps
* Create DynamoDB
  * Table name: post
  * Primary key: id
* Create 2 public S3 buckets
  * host the website
  * hold converted MP3s
* Create SNS topic
  * name: new_posts
  * display name: new post
* Create IAM roles
  * Allow lambda to interact with DynamoDB, S3, Polly, and SNS
  * Create policy from JSON policy `LambdaPolicyForPolly`
  ```{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": [
                "polly:SynthesizeSpeech",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:PutItem",
                "dynamodb:UpdateItem",
                "sns:Publish",
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetBucketLocation",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
           ],
           "Resource": [
               "*"
           ]
       }
   ]
}```
  * Create Lambda role with `LambdaPolicyForPolly` policy. Name it `LambdaRoleForPolly`
* Create 3 lambda functions
  * new post 
    * PostReader_NewPosts, role: LambdaPolicyForPolly
    * Environment Variables: `DB_TABLE_NAME: post`, `SNS_TOPIC: <ARN of `new_posts` topic>`
    * Test Event: ```{ "voice" : "Joanna", "text" : "what up doe?" }```
    * Check DynamoDB for the item after submitting test event
  * convert to audio
    * PostReader_Convert2Audio, role: LambdaPolicyForPolly
    * Trigger: SNS notification (`new_posts`)
    * Environment Variables: `DB_TABLE_NAME: post`, `BUCKET_NAME: <name of mp3 bucket>`
    * Change timeout to 5 min
  * get post
    * PostReader_GetPosts, role: LambdaPolicyForPolly
    * Environment Variables: `DB_TABLE_NAME: post`
    * Test Event: ```{ "postId": "*" }```
    * Execution Result shows all post IDs
* Create API Gateway
  * API Name: PostReaderAPI
    * GET method 
      * Integration type: Lambda
      * Region: us-east-1
      * Lambda Function: PostReader_GetPosts
      * Enable CORS
      * Add Query String: `postId`
      * Body Mappings Templates: `Request body passthrough when there are no templates defined`. Content Type: `application/json`. Copy/ paste `mappings.json`
    * POST method
      * Integration type: Lambda
      * Region: us-east-1
      * Lambda Function: PostReader_NewPost
      * Enable CORS
* Deploy API and note URL
* Upload web host code
  * Paste bucket policy (add correct ARN for website bucket)
  * Add API URL to `API_ENDPOINT` variable in the code
  * Upload index.html, scripts.js, styles.css
