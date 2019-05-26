local connection
if (getServerPort() == 22003) then 
    connection = dbConnect("mysql","dbname=admin_mtasa;host=127.0.0.1","putMySQLDatabase","PutYourPasswordIn")
else
    connection = dbConnect("mysql","dbname=admin_mtadev;host=127.0.0.1","putMySQLDatabase","PutYourPasswordIn")
end 

-- Get the MySQL connection element
function getConnection() 
    return connection
end

-- Get a MySQL query
function query ( ... )
    if ( connection ) then
        local qh = dbQuery( connection, ... )
        return dbPoll(qh,-1)
    end
    return false
end

-- Get a single row from the database
function querySingle ( str, ... )
    if ( connection ) then
        local qh = dbQuery( connection, str, ... )
        local result = dbPoll(qh,-1)
        if (result) then
            return result[1]
        else
            return false
        end
    else
        return false
    end
end

-- MySQL database execute
function exec ( str, ... )
    if ( connection ) then
        local qh = dbExec( connection, str, ... )
        local result = qh
        if (qh == false) then
            dbFree(qh)
        end
        return result
    else
        return false
    end
end

-- Check if a column exists
function doesColumnExist ( aTable, column )
    local theTable = query ( "DESCRIBE `??`", aTable )
    if ( theTable ) then
        for k, aColumn in ipairs ( theTable ) do
            if ( aColumn.Field == column ) then
                return true
            end
        end
        return false
    else
        return false
    end
end

-- Function that creates a column
function creatColumn ( aTable, aColumn, aType )
    if ( aTable ) and ( column ) and ( aType ) then
        exec ( "ALTER TABLE `??` ADD `??` ??", aTable, aColumn, aType )
        return true
    else
        return false
    end
end
