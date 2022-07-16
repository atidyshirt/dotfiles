require('orgmode').setup({
    org_highlight_latex_and_related = 'native',
    org_agenda_files = {'~/org/**/*'},
    org_default_notes_file = '~/org/refile.org',
    org_capture_templates = { 
        j = {
            description = 'Journal',
            template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
            target = '~/org/journal.org'
        }
    }
})
