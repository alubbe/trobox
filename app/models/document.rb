class Document < ActiveRecord::Base
  extend Enumerize

  enumerize :document_type, in: {'Schufa Auskunft' => 1, 'Kopie Personalausweis' => 2, 'Einkommensnachweis' => 3, 'Mietzahlungsbestätigung' => 4, 'WBS-Schein' => 5, 'Bürgschaftserklärung' => 6, 'Kopie Personalausweis (Bürge)' => 7}

  belongs_to :user

  attr_accessor :file

  before_create :upload_file_to_box
  before_update :update_file_in_box


  def upload_file_to_box
    box_file = user.box_client.upload_data("trobox/documents/#{document_type.text.parameterize}.#{file.original_filename.split('.').last}",file.tempfile, true)
    item = box_file
    fp = []
    begin
      fp << item.name
      last_item_name = item.name
      item = item.parent
    end while last_item_name != 'trobox'
    self.box_file_path = fp.reverse.join('/')
    folder = user.box_client.folder("/trobox")
    folder.sync_state = 'synced'
    folder.update
  end

  def update_file_in_box
    box_file = user.box_client.file(self.box_file_path).delete
    upload_file_to_box
  end
end
