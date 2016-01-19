Redmine::Plugin.register :projects_treeview do
  name 'Projects Treeview plugin'
  author 'Thomas Koch'
  description 'Offers alternate projects browser(tree view).'
  version '0.1'
  url 'https://github.com/braini75/projects_treeview.git' 
  author_url 'https://github.com/braini75' 
  
  menu :top_menu, :projects_treeview, { :controller => 'treeview', :action => 'index' }, :caption => :projects_treeview_title
end
