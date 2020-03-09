#!/bin/bash

# params: $1 ruta del proyecto *obligatiorio
          # $2 dependencias  OPCIONALEs           
          # $3 dependencias de desarrollo OPCIONALEs
          # $4 componentes si es que necesitamos  OPCIONALEs
# ejemplo de uso:  ./reactDocuments.sh my-proyect 'node-sass react-router react-router-dom' 'eslint prettier eslint-plugin-react' 'componenteUno componenteDos'

if [ "$1" ];
  then 
    ruta=$1;
    create-react-app $ruta;
    cd $ruta/src;
    mkdir -p components/App assets constants;
    mv App.js componets/App/index.js;
    mv App.css componets/App/index.css;
    sed -i 's/\/App/\/components\/App/g' index.js;
    head -n 8 index.js | grep -v serviceWorker > index.js;
    rm logo* App* se*.js;
  else 
    echo "Debe ingresar el nombre del proyecto del proyecto"
fi

#depencencies
if [ "$2" ]; 
  dependencies=$2;
  then 
    for i in ${dependencies[@]}
      do
       npm install $i
    done
fi

#devDepencencies
if [ "$3" ]; 
  devDependencies=$3
  then 
    for i in ${devDependencies[@]}
      do
       npm install --save-dev $i
    done
fi

#COMPONENTS
if [ "$4" ]; 
  then 
    componets=$4
    for i in ${componets[@]}
      do
       mkdir components/$i;
       touch components/$i/index.{js,module.scss};
    done
fi

#cd ../;
#npm start;
#code . 
