export const verifyRole = (...allowedRoles) => {
    return (req, res, next) => {
        try {
            if(!req?.roles) return res.status(401).json({message: 'Invalid user'})
            const rolesArray = [...allowedRoles] 
            const result = req.roles.map(role => rolesArray.includes(role)).find(val => val === true)
            if(!result) return res.status(401).json({message: 'User do not have permission'})
            next()
        } catch (error) {
            return res.status(401).json({message: error.message})
        }
    }
}