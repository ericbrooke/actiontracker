module Admin::PermissionsHelper
  def permissions
    {
      "view" => "View",
      "create actions" => "Create Actions",
      "edit actions" => "Edit Actions",
      "delete actions" => "Delete Actions"
    }
  end
end
