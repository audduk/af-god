--возвращает отряды идущие на кузницу
local function forgeCreeps(squads,forgeId)
    if squads~=nil then
        local creepsCount = 0
        while squads:MoveNext() do
            if squads.Current.ToId==forgeId then
                creepsCount = creepsCount + squads.Current.CreepsCount
            end
        end

        return creepsCount
    else
        return 0
    end
end

local function getEnemy(enemies,myTeam)
	while enemies:MoveNext() do
        if enemies.Current:ToString()~='White' then
            if enemies.Current~=myTeam then
                return enemies.Current
            end
        end
    end
    return nil
end

local state
local buildings 
local myBuildings
local enemyBuildings
local forge
local myForgeCreeps  --мои войска в кузнице
local enemyForgeCreeps  --вражеские войска в кузнице

local myTeam = Game.Team
local enemyTeam = getEnemy(Game.Enemies:GetEnumerator(),myTeam)

--максимальное количество крипов в башне
local buildingMaxCreeps = Game.GameParameters.Towers.PlayerMaxCount

Game:Debug('buildingMaxCreeps: '..buildingMaxCreeps)

--Game:Debug('My team: '..myTeam:ToString()..'; Enemy: '..enemyTeam:ToString())

while true do
    state = Game:GetState()

    --Game:Debug('Lua Bot: '..state.Tick..' tick')   

    myBuildings = Game:GetBuildingStates(state, myTeam):GetEnumerator()

    enemyBuildings = Game:GetBuildingStates(state, enemyTeam):GetEnumerator() 

    buildings = state.BuildingStates:GetEnumerator()
	while buildings:MoveNext() do
        if buildings.Current.Type:ToString()=='Forge' then  --ищем кузницу
            forge = buildings.Current
    	    --Game:Debug('Buildings Id: '..buildings.Current.Id..'; Buildings team: '..buildings.Current.Team:ToString()..'; Creeps:'..buildings.Current.CreepsCount..'; BuildingType: '..buildings.Current.Type:ToString()..'; CanSendCreeps: '..tostring(buildings.Current.CanSendCreeps))
        end
    end

    if forge~=nil then  --если кузница есть

        --Game:Debug('Forge: '..forge.CreepsCount..'; Team: '..forge.Team:ToString())

        myForgeCreeps = 0  
        enemyForgeCreeps = 0  

        if forge.Team == myTeam then myForgeCreeps = myForgeCreeps + forge.CreepsCount else enemyForgeCreeps = enemyForgeCreeps + forge.CreepsCount end

        enemyForgeCreeps = enemyForgeCreeps + forgeCreeps(Game:GetSquadStates(state, enemyTeam):GetEnumerator(),forge.Id)  --вражеские войска которые идут в кузницу

        myForgeCreeps = myForgeCreeps + forgeCreeps(Game:GetSquadStates(state, myTeam):GetEnumerator(),forge.Id)  --мои войска, которые идут в кузницу

        if myForgeCreeps <= enemyForgeCreeps + 10 then
            while myBuildings:MoveNext() do
                if myBuildings.Current.CreepsCount>forge.CreepsCount then
    	            --Game:Debug('myBuildings Id: '..myBuildings.Current.Id..'; myBuildings team: '..myBuildings.Current.Team:ToString()..'; Creeps:'..myBuildings.Current.CreepsCount..'; myBuildingsType: '..myBuildings.Current.Type:ToString()..'; CanSendCreeps: '..tostring(myBuildings.Current.CanSendCreeps))

                    local part = (enemyForgeCreeps+10)/myBuildings.Current.CreepsCount+0.1

                    if part>1 then part=1 end

                    Game:Move(myBuildings.Current.Id,forge.Id,part)
                end
            end
        end
    end

    --myBuildings:Reset()
    myBuildings = Game:GetBuildingStates(state, myTeam):GetEnumerator()
    while myBuildings:MoveNext() do
        if myBuildings.Current.CreepsCount >= 0.9*buildingMaxCreeps then
            --Game:Debug('myBuildings Id: '..myBuildings.Current.Id..'; myBuildings team: '..myBuildings.Current.Team:ToString()..'; Creeps:'..myBuildings.Current.CreepsCount..'; myBuildingsType: '..myBuildings.Current.Type:ToString()..'; CanSendCreeps: '..tostring(myBuildings.Current.CanSendCreeps))
            Game:Move(myBuildings.Current.Id,forge.Id,0.2)
        end
    end

    if forge.Team == myTeam then
        if forge.CreepsCount>(buildingMaxCreeps * 1.2) then
            while enemyBuildings:MoveNext() do
                Game:Move(forge.Id,enemyBuildings.Current.Id,1)
                break
            end
        end
    end                    

end