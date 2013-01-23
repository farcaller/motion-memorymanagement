require "motion-memorymanagement/version"

Motion::Project::App.setup do |app|
  # rip off from teacup. All this dependency injection sucks, can we haz better gem support?..
  # scans app.files until it finds app/ (the default)
  # if found, it inserts just before those files, otherwise it will insert to
  # the end of the list
  insert_point = 0
  app.files.each_index do |index|
    file = app.files[index]
    if file =~ /^(?:\.\/)?app\//
      # found app/, so stop looking
      break
    end
    insert_point = index + 1
  end

  app.files.insert(insert_point, File.dirname(__FILE__) + '/motion-memorymanagement/runtime_helpers.rb')

  mmRoot = File.expand_path(File.dirname(__FILE__) + '/../MMRuntime')
  app.vendor_project(mmRoot, :static, :headers_dir => 'MMRuntime')
end

