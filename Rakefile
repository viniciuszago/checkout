require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['specs/**/*.rb']
  t.verbose = true
  t.warning = true
end