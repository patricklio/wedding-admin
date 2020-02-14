const initSideBarToggle = () => {
    toggleSidebar();
}

const toggleSidebar = () => {
    $(document).ready(function() {
        $('.sidebar-collapse').click(function() {
            if ($('.page-container').hasClass('sidebar-collapsed')) {
                $('.page-container').removeClass('sidebar-collapsed');
            } else {
                $('.page-container').addClass('sidebar-collapsed');
            }
        });

        // Add active for menu that has sub menu
        var url = window.location;
        // for sidebar menu entirely but not cover treeview
        const selected = $('.sub-menu li > a').filter(function() {
            return this.href == url;
        });
        if (selected) {
            selected.parent().addClass('active');
            selected.parents('li').addClass('active')
        }
    });
}

export { initSideBarToggle }