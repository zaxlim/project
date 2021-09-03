const swaggerAutogen = require('swagger-autogen')()

const outputFile = './swagger_output.json'
const endpointsFiles = ['./user.js','./contract.js']

swaggerAutogen(outputFile, endpointsFiles).then(() => {
    require('./main.js')
})