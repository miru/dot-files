#!/bin/bash

pushd ~/Dropbox/narou
#for n in n6847co n7594ct n4527bc n2267be n4553db n8611bv n5705ch n3680db n4605bu n9424cz n9078bd n1875cl n7782ci n3662ce n8976da n9902bn n7194da n5103cj n7460cv n0744bf n9021cb n6768bf n7648bn n7863bx n1121dd n6743cv n3762bt n8725k n9505bf n7590cy n0576cl n5728cu n3508bc n3571o n7004bv n5077bk n1629ch n1388cw n0885dc n5943db n8906cc n4259s n9673bn n7126cq n7362cy n7789cr n8915bv n6247cr n6819da n5966cb n9985cb n5391ci n5881cl n1407db n9073ca n1792df n1222ci n5115cq n7708db n4157dc n6475db n0537cm n5708cr n3009bk n3048cv n9703db n0813db n5824ct n0904cx n4054by n1576cu n1089a n5428de n1094bz n8697cx n7585dd n8162cb n9838bp n1044dc n0733cr n7975cr n1653cx n7657cq n2301db n6316bn n4698cv n5375cy n4269cp n7135cx n6332bx n8523ct n8802bq n4830bu n7835cj n4099cd n8201cq n9734bb n9669bk n4251cr n4202cb n5529cy n8067ce n2662ca
#do
#  narou u $n
#done

/usr/local/bin/narou u 
cp -fp ./**/*.mobi ~/narou/converted/Kindle
cp -fp ./**/*.epub ~/narou/converted/EPUB

popd

# EOF

