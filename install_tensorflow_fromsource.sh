mkdir /root/dev
cd /root/dev
git clone http://github.com/russell91/tensorbox
#cd tensorbox/
#./download_data.sh 
cd /root/dev
git clone --recurse-submodules https://github.com/tensorflow/tensorflow
#cp tensorbox/utils/hungarian/hungarian.cc tensorflow/tensorflow/core/user_ops/
sudo add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java8-installer
echo "deb http://storage.googleapis.com/bazel-apt stable jdk1.8" |tee /etc/apt/sources.list.d/bazel.list
curl https://storage.googleapis.com/bazel-apt/doc/apt-key.pub.gpg | apt-key add -
apt-get update && sudo apt-get install bazel
apt-get upgrade bazel
apt-get install python-numpy swig python-dev
cd /root/dev/tensorflow
./configure 
   51  which python
   52  ./configure 
   53  bazel build -c opt --config=cuda //tensorflow/cc:tutorials_example_trainer
   54  bazel build -c opt //tensorflow/tools/pip_package:build_pip_package
   55  bazel build -c opt --config=cuda //tensorflow/tools/pip_package:build_pip_package
   56  bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg
   57  pip install /tmp/tensorflow_pkg/tensorflow-0.9.0-py2-none-any.whl 
   58  cd ..
   59  cd tensorbox/utils/
   60  make
   61  cd ..
   62  python train.py --hypes hypes/lstm_rezoom.json --gpu 0 --logdir output
   63  ls
   64  cd hypes/
   65  ls
   66  vim lstm_rezoom.json 
   67  cd ..
   68  ls
   69  tensorboard --logdir output
   70  history
   71  history > ~/sharedfolder/install_tensorflow_fromsource.txt
