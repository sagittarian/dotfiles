# fdna
alias alc='workon alc && cd algo_code'
alias rungw='gunicorn -b 0.0.0.0:9000 --log-file=- --access-logfile=- --error-logfile=- greenwood.greenwood:app'

alias agentify='eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa_fdna'
