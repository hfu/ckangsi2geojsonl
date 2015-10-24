require 'open-uri'
require 'json'

JSON.parse(open('http://ckan.gsi.go.jp/api/3/action/package_list').
  read)['result'].each{|id|
  n_tries = 0
  begin
    record = JSON.parse(open(
      "http://ckan.gsi.go.jp/api/3/action/package_show?id=#{id}").
      read)['result']
    title = record['title']
    extras = record['extras']
    geometry = nil
    extras.each{|r|
      next unless r['key'] == 'spatial'
      geometry = JSON.parse(r['value'])
    }
  rescue
    n_tries += 1
    if n_tries < 5
      sleep rand
      $stderr.print "retry ##{n_tries} for #{id}\n"
      retry
    end
  end
  print JSON.dump({
    :type => 'Feature',
    :geometry => geometry,
    :properties => {:id => id, :title => title}
  }), "\n" if geometry
}
