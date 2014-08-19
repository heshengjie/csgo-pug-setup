/**
 * Displays a menu to select the captains for the game.
 */
public Captain1Menu(client) {
    new Handle:menu = CreateMenu(Captain1MenuHandler);
    SetMenuTitle(menu, "Chose captain 1:");
    if (AddPotentialCaptains(menu, g_capt2) >= 1)
        DisplayMenu(menu, client, MENU_TIME_FOREVER);
    else
        CloseHandle(menu);
}

public Captain1MenuHandler(Handle:menu, MenuAction:action, param1, param2) {
    if (action == MenuAction_Select) {
        new client = param1;
        new choice = GetMenuInt(menu, param2);
        SetCapt1(choice);
        Captain2Menu(client);
    } else if (action == MenuAction_End) {
        CloseHandle(menu);
    }
}

public Captain2Menu(client) {
    new Handle:menu = CreateMenu(Captain2MenuHandler);
    SetMenuTitle(menu, "Chose captain 2:");
    if (AddPotentialCaptains(menu, g_capt1) >= 1)
        DisplayMenu(menu, client, MENU_TIME_FOREVER);
    else
        CloseHandle(menu);
}

public Captain2MenuHandler(Handle:menu, MenuAction:action, param1, param2) {
    if (action == MenuAction_Select) {
        new choice = GetMenuInt(menu, param2);
        SetCapt2(choice);
    } else if (action == MenuAction_End) {
        CloseHandle(menu);
    }
}

static AddPotentialCaptains(Handle:menu, otherCaptain) {
    new count = 0;
    for (new client = 1; client <= MaxClients; client++) {
        if (IsValidClient(client) && !IsFakeClient(client) && otherCaptain != client) {
            decl String:name[MAX_NAME_LENGTH];
            GetClientName(client, name, sizeof(name));
            AddMenuInt(menu, client, name);
            count++;
        }
    }
    return count;
}

/**
 * Extra menu for selecting the leader of the game.
 */
 public LeaderMenu(client) {
    new Handle:menu = CreateMenu(LeaderMenuHandler);
    SetMenuTitle(menu, "Chose the game leader:");
    if (AddAllPlayers(menu) >= 1)
        DisplayMenu(menu, client, MENU_TIME_FOREVER);
    else
        CloseHandle(menu);
}

public LeaderMenuHandler(Handle:menu, MenuAction:action, param1, param2) {
    if (action == MenuAction_Select) {
        new choice = GetMenuInt(menu, param2);
        SetLeader(choice);
    } else if (action == MenuAction_End) {
        CloseHandle(menu);
    }
}

static AddAllPlayers(Handle:menu) {
    return AddPotentialCaptains(menu, -1); // adds everyone (excludes client -1)
}