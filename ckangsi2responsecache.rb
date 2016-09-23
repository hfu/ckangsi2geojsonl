require 'open-uri'
require 'json'
require 'msgpack'

count = 0
File.open('responsecache.msg', 'wb') {|w|
  result = JSON.parse(open('http://ckan.gsi.go.jp/api/3/action/package_list').
  read)['result']
  result.each{|id|
    n_tries = 0
    record = nil
    begin
      record = JSON.parse(open(
        "http://ckan.gsi.go.jp/api/3/action/package_show?id=#{id}").
        read)['result']
    rescue
      n_tries += 1
      if n_tries <= 50
        sleep rand
        $stderr.print "retry ##{n_tries} for #{id}\n"
        retry
      end
    end
    next unless record
    count += 1
    msg = record.to_msgpack
    record_size = JSON.dump(record).size
    w.print msg
    print "#{Time.now} ##{count}/#{result.size}=#{(100.0 * count / result.size).round}% #{msg.size}/#{record_size}=#{(100.0 * msg.size / record_size).round}%\n"
  }
}
