Rails.application.routes.draw do

  mount Vfs::Engine => "/vfs"
end
