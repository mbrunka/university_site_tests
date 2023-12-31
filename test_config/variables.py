# JENKINS CONFIGURABLE VARIABLES IF RUN LOCALY UNCOMMENT AND FILL WITH YOUR CREDENTIALS
# Provided in Jenkins Windows Agent in file C:/Jenkins/secret.py
# for local testing uncomment and fill with your cridentials.
# EMAIL = "*******@****.**"
# PASSWD = "*********"
# BROWSER = "Edge"
USER_FULL_NAME = "Michał Brunka"
# Current semester, either SUMMER or WINTER
CURRENT_SEMESTER = "WINTER"
# --------------------------------------------
# NOT JENKINS CONFIGURABLE VARIABLES

# Global Variables
MAIN_PAGE_URL = "https://www.put.poznan.pl/"
MAIL_URL = "https://elogin.put.poznan.pl/email/#1"
FACULTY_PAGE = "https://www.cat.put.poznan.pl/"
ICT_STUDENT_PAGE = "https://www.cat.put.poznan.pl/dla-studentow/teleinformatyka"
EKURSY_URL = "https://ekursy.put.poznan.pl/login/index.php"
INTRANET = False

# Folder paths, relative to project root
TEST_CONFIG_FOLDER = "./test_config"
TEMP_FOLDER = "./test_config/temp"