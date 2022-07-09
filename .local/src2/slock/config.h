/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nogroup";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
	[PAM] =    "#9400D3", 	/* waiting for PAM */
};

/* Xresources preferences to load at startup */
ResourcePref resources[] = {
		{ "color0",       STRING,  &colorname[INIT] },
		{ "color4",       STRING,  &colorname[INPUT] },
		{ "color1",       STRING,  &colorname[FAILED] },
		{ "color5",       STRING,  &colorname[PAM] },
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* Offset for the lockscreen message in pixels */
static const int xoffset = 1920;
static const int yoffset = 0;

/* PAM service that's used for authentication */
static const char * pam_service = "login";

/* default message */
static const char * message = "Check your xsidle.sh and xinitrc to make sure you're properly running slock";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "6x13";

