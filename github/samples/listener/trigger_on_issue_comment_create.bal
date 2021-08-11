// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/websub;
import ballerina/log;
import ballerinax/github.webhook as github;

listener github:Listener webhookListener = new (9090);

configurable string githubTopic = ?;
configurable string githubSecret = ?;
configurable string githubCallback = ?;
configurable string accessToken = ?;

@websub:SubscriberServiceConfig {
    target: [github:HUB, githubTopic],
    secret: githubSecret,
    callback: githubCallback,
    httpConfig: {
        auth: {
            token: accessToken
        }
    }
}
service /subscriber on webhookListener {

    remote function onIssueCommentCreated(github:IssueCommentEvent event) returns github:Acknowledgement? {
        log:printInfo("Issue comment created", notificationMsg = event);
        // Write your logic here.....
    }

}