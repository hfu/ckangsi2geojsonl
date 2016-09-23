task :default do
  sh "ruby ckangsi2geojsonl.rb > ckangsi.geojsonl"
  sh "ruby geojsonl2geojson.rb > ckangsi.geojson"
end
task :msgpack do
  sh "ruby ckangsi2geomsgpackl.rb > ckangsi.msgpackl"
  sh "ruby msgpackl2geomsgpack.rb > ckangsi.msgpack"
end
