pipeline {
    agent any
    stages {
        stage('Install kubectl') {
            steps {
                sh '''
                    curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.16.8/2020-04-16/bin/linux/amd64/kubectl &&\
                    chmod +x ./kubectl &&\
                    mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin &&\
                    kubectl version --short --client
                '''
            }
                    
        }
        
        stage('Install eksctl') {
            steps {
                sh '''
                    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp &&\
                    sudo mv /tmp/eksctl /usr/local/bin &&\
                    eksctl version
                '''
            }
        }
    
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
