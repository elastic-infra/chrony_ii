# For Chef 15.0-15.2
# Those versions of Chef do not have unified_mode implementation.
# This patch provides a dummy unified_mode method for such versions.

module ChefResourcePatch
  def unified_mode(flag = nil)
    flag
  end
end

if Chef::VERSION >= '15.0' && Chef::VERSION < '15.3'
  Chef::Resource.extend(ChefResourcePatch)
end
