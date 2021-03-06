pipeline {

    agent any
    
    stages {
    	
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
	            sh 'docker build -t aberdean/capstone:v3 .'
	        }
	    }
	    
	    stage('Upload Docker image to Docker Hub') {
	        steps {
	            withDockerRegistry([url: '', credentialsId: 'dockerhub']) {
	                sh '''
    	                docker push aberdean/capstone:v3
    	            '''
	            }
	        }
	    }
	    
	    stage('Set current kubectl context') {
	    	steps {
	    		withAWS(region:'us-west-2', credentials:'Capstone') {
	    			sh '''
	    				kubectl config use-context arn:aws:eks:us-west-2:326144634472:cluster/capstone
	    			'''
	    		}
	    	}
	    }
	    
	    stage('Deploy app') {
	    	steps {
	    		withAWS(region:'us-west-2',credentials:'Capstone') {
	    			sh 'kubectl apply -f https://raw.githubusercontent.com/aberdean/devops-capstone-project/master/deployment.yaml'
	    		}
	    	}
	    }
	    
	    stage('Add load balancer') {
	    	steps {
	    		withAWS(region:'us-west-2',credentials:'Capstone') {
	    			sh 'kubectl apply -f https://raw.githubusercontent.com/aberdean/devops-capstone-project/master/service.yaml'
	    		}
	    	}
	    }
	    
	    stage('Check deployment rollout') {
	    	steps {
	    		withAWS(region:'us-west-2',credentials:'Capstone') {
	    			sh 'kubectl rollout status deployment capstone-deployment'
	    		}
	    	}
	    }
	    
	    stage('Check final deployment') {
	    	steps {
	    		withAWS(region:'us-west-2',credentials:'Capstone') {
	    			sh 'kubectl get deployment capstone-deployment'
	    		}
	    	}
	    }
    }
}
