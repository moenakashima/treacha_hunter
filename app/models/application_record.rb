class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def update_with_context(new_attributes, context)
    with_transaction_returning_status do
      assign_attributes(new_attributes)
      save(context: context)
    end
  end
end
