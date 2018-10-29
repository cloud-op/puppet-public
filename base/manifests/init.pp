class base {
	include base::user_hadoop
	include base::user_admin
	include base::user_dev
	include base::yum_repo
	include base::package
	include base::limits	
	include base::swapoff
	include base::service
}
