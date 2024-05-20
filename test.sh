   #!/bin/sh
   echo "This script is running with: /bin/sh"
   ps -p $$ -o comm=
   EOF

   chmod +x test.sh

