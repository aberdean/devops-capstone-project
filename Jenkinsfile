pipeline {

    agent any
    
    stages {
    	
    	stage('Create cluster') {
    		when {
    			expression {
    				STACK_COMPLETE = withAWS(region:'us-west-2',credentials:'Capstone') {
    					sh(returnStdout: false, script: 'aws cloudformation wait stack-create-complete --stack-name capstone')
    				}
    				return STACK_COMPLETE == 'Waiter StackCreateComplete failed: Waiter encountered a terminal failure state'
    			}
    		}
    		steps {
    			build job: 'setup-cluster/Jenkinsfile', propagate: true, wait: true
    		}
    	}
    	
    	stage('Skip cluster creation') {
    		when {
    			expression {
    				STACK_COMPLETE = withAWS(region:'us-west-2',credentials:'Capstone') {
	    				sh(returnStdout: false, script: 'aws cloudformation wait stack-create-complete --region us-west-2 --stack-name capstone')
	    			}
    				return !(STACK_COMPLETE == 'Waiter StackCreateComplete failed: Waiter encountered a terminal failure state')
    			}
    		}
    		steps {
    			echo 'Skipped cluster creation. Cluster already exists.'
    		}
    	}
    	
        stage('Lint HTML') {
	        steps {
                sh 'tidy -q -e *.html'
	        }    
	    }
	    
	    stage('Lint Dockerfile') {
	        steps {
	            sh 'hadolint Dockerfile'
	        }
	    }
	    
	    stage('Build Docker image') {
	        steps {
	            sh 'docker build --tag=capstoneimage .'
	        }
	    }
	    
	    stage('Upload Docker image to Docker Hub') {
	        steps {
	            withDockerRegistry([url: '', credentialsId: 'dockerhub']) {
	                sh '''
    	                docker tag capstoneimage aberdean/capstone &&\
    	                docker push aberdean/capstone
    	            '''
	            }
	        }
	    }
    }
    
}
