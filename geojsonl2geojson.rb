require 'json'
collection = {:type => 'FeatureCollection', :features => []}
File.foreach('ckangsi.geojsonl') {|l|
  feat = JSON.parse(l.strip)
  if feat['geometry']['type'] == 'Polygon'
    feat['geometry']['coordinates'].each {|ring|
      if ring.first != ring.last
        ring.push(ring.first)
      end
    }
  end
  collection[:features].push(feat)
}
print JSON.dump(collection), "\n"
