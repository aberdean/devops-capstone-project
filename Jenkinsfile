pipeline {
    agent any
    stages {
	    stage('Create Kubernetes cluster') {
	       steps {
	            withAWS(region:'us-west-2',credentials:'Capstone') {
	                sh '''
	                    eksctl create cluster \
                            --name capstone \
                            --version 1.16 \
                            --region us-west-2 \
                            --nodegroup-name standard-workers \
                            --node-type t2.micro \
                            --nodes 2 \
                            --nodes-min 2 \
                            --nodes-max 4 \
                            --managed
                    '''
	            }
	        }
	    }
    }
}
