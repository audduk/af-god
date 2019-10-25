-- Получение команды бота
local botTeam = Game.Team -- ("White", "Red", "Blue")

if botTeam:ToString() == "Red" then

end

-- Получение вражеских команд
local enemies = Game.Enemies:GetEnumerator()

--Перебор в цикле значений из коллекции
while enemies:MoveNext() do
  if it:ToString() == "Red" then

  end
end

-- Получение текущего стейта
local state = Game:GetState()

-- Получение длины(целочисленное значение) между строением с идентификаторов 2 и строением с идентификатором 5
Game.Map.Links.GetDistance(2, 5)

-- Получение текущего стейта
local state = Game:GetState()
state.Tick -- Внутриигровой тик(целочисленное значение), в который создано состояние

--Получение строений пользователя(botTeam) и их состояния
local buildings = Game:GetBuildingStates(state, botTeam):GetEnumerator()

--Перебор в цикле значений из коллекции
while buildings:MoveNext() do
  it.Id -- id строения(целочисленное значение)
  it.Type -- тип строения -- ("None", "Tower", "Forge")
  if it.Type:ToString() == "Forge" then

  end
  it.CreepsCount -- Количество войск в башне(целочисленное значение)
  it.Team -- Какой команде принадлежит  -- ("White", "Red", "Blue")
end

--Получение отрядов пользователя(botTeam) и их состояния
local squads = Game:GetSquadStates(state, botTeam):GetEnumerator()

--Перебор в цикле значений из коллекции
while squads:MoveNext() do
  it.FromId -- id строения из которого выслан отряд(целочисленное значение)
  it.ToId -- id строение в которое отправлен отряд(целочисленное значение)
  it.Team -- какой команде принадлежит -- ("White", "Red", "Blue")
  it.CreepsCount -- количество войнов в отряде (целочисленное значение)
  it.Speed -- скорость (метров в  1 тик)(вещественное значение)
  it.Traveled -- Часть пути, которую прошел отряд [0; 1](вещественное значение)
end

-- Команда на перемещение 20% отряда из строения с идентификаторов 0 в строение с идентификатором 10
-- (доступные значения: 0.2, 0.4, 0.6, 0.8, 1.0 Если будет отправлено
-- значение отличное от перечисленных, то оно будет округлено к ближайшему значению из списка)
Game:Move(0, 10, 0.2)

-- Придать ускорение отряду 5
Game:Boost(5)

-- Продолжительность битвы в тиках(целочисленное значение)
Game.GameParameters.Duration

-- Стандартный множитель защиты здания при атаке вражеской команды. При нападении на здания
-- нападающая сторона терят войнов больше чем обороняющаяся в DefaultDefenseParameter раз.
Game.GameParameters.DefaultDefenseParameter

-- Настройки башен на карте
Game.GameParameters.Towers.PlayerMaxCount -- Максимальное количество войск в строении, если оно принадлежит команде игрока
Game.GameParameters.Towers.NeutralMaxCount -- Максимальное количество войск в строении, если оно принадлежит нейтральной команде

-- Настройки кузниц на карте
Game.GameParameters.Forges.PlayerMaxCount -- Максимальное количество войск в строении, если оно принадлежит команде игрока
Game.GameParameters.Forges.NeutralMaxCount -- Максимальное количество войск в строении, если оно принадлежит нейтральной команде
Game.GameParameters.Forges.DefenseBonus -- Прибавка к множителю защиты для всех строений команды, которая владеет кузницей(вещественное число)

-- Настройки крипов на карте
Game.GameParameters.Creeps.Speed -- Скорость перемещения крипов. (Метров в 1 тик)
Game.GameParameters.Creeps.SpeedModifier -- Ускорение (в SpeedModifier раз) при применении баффа ускорения(Вещественное число)
Game.GameParameters.Creeps.CreationTime -- Время создания крипов в строениях в тиках. (за столько внутриигровых тиков создается 1 воин в башне) (целочисленное значение)
