#!/bin/bash

#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================

echo "=============================================================================================================="
echo "Please run the script as: "
echo "Usage: bash scripts/run_eval.sh [DEVICE_ID] [模型权重路径] [验证模式] [数据路径]"
echo "for example: bash cripts/run_eval.sh 0 'path/xx.ckpt' test '/home/ma-user/work/data/{}' "
echo "It is better to use absolute path."
echo "================================================================================================================="

if [ $# != 4 ]
then
    echo "Usage: bash scripts/run_eval.sh [DEVICE_ID] [CKPTPATH] [EVALTYPE] [DATAPATH]"
    exit 1
fi

echo "After running the script, the network runs in the background. The log will be generated in LOGx/log.txt"

export DEVICE_ID=$1
CKPTPATH=$2
EVALTYPE=$3
DATAPATH=$4



rm -rf LOG$1
mkdir ./LOG$1
cp ./*.py ./LOG$1
cp -r ./src ./LOG$1
cd ./LOG$1 || exit

echo "start eval for device $1"

env > env.log

python eval.py      
---ckpt=$CKPTPATH \
--eval_type=$EVALTYPE \
--data_path=$DATAPATH > log.txt 2>&1 &

cd ../