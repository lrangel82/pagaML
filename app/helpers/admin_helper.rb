module AdminHelper
  # def form_with(**options)
  #   if options[:model]
  #     class_name = options[:model].class.name.demodulize.underscore
  #     create_route_name = class_name.pluralize

  #     #create_route_name = options[:url].demodulize.underscore unless options[:url].nil?
  #     options[:scope] = class_name
  #     options[:url] = if options[:model].new_record?
  #                       send("admin_#{create_route_name}_path")
  #                       # form action = "customers_path"
  #                     else
  #                       send("admin_#{class_name}_path", options[:model])
  #                       # form action = "customer/45"
  #                     end

  #     # post for create and patch for update:
  #     options[:method] = :patch if options[:model].persisted?

  #     options[:model] = nil

  #     super
  #   end
  # end
end
