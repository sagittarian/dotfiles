pipeline {
    agent { label 'dotfiles-worker' }
    options {
        disableConcurrentBuilds()
    }
    stages {
        stage('Checkout') {
            steps {
                timeout(5) {
                    git url: 'git@github.com:sagittarian/dotfiles.git'
                }
            }
        }
        stage('Check for vault password file') {
            steps {

            }
        }
        stage('Vagrant up') {
            steps {
                sh '''
                   if [ ! -d $vagrantdir ]; then
                       mkdir -p $vagrantdir
                       cp $basedir/Vagrantfile $basedir/provision.sh $vagrantdir
                   fi
                   cd $vagrantdir
                   vagrant up'''
            }
        }
        stage('Run dotfile configuration') {
            when {
                expression {
                    jobname = env.JOB_NAME.split("/")[1];
                    return (jobname == 'master') || (jobname.startsWith("PR-"));
                }
            }
            steps {
                timeout(60) {
                    timestamps {
                        sh '''
                            echo Vagrant up and provisioned, running dotfile configuration
                            script=$(cat $basedir/moon.sh | sed -e "s/\$vpass/$vpass/")
                            vagrant ssh -c "$script"'''
                    }
                }
            }
        }
        stage('Test configuration') {
            steps {
                timeout(5) {
                    timestamps {
                        sh '''
                            echo Testing that the system has been properly installed
                            tests=$(cat $basedir/test_system.sh)
                            vagrant ssh -c "$tests"'''
                    }
                }
            }
        }
        stage('Destroy VM') {
            steps {
                timeout(15) {
                    timestamps {
                        sh '''
                            echo Destroying vagrant VM
                            vagrant destroy --force'''
                    }
                }
            }
        }
    }
}

