const mysql = require('mysql2/promise');
const Redis = require('ioredis');
const amqp = require('amqplib');
require('dotenv').config();

const rdsConfig = {
  host: process.env.RDS_HOST,
  user: process.env.RDS_USER,
  password: process.env.RDS_PASSWORD,
  database: process.env.RDS_DB_NAME,
};

const redisClient = new Redis({
  host: process.env.REDIS_HOST,
  port: process.env.REDIS_PORT,
});

const rabbitMQUrl = process.env.RABBITMQ_URL;

module.exports.saveData = async (event) => {
  const data = JSON.parse(event.body);

  // Save data to RDS
  const connection = await mysql.createConnection(rdsConfig);
  const [rows, fields] = await connection.execute('INSERT INTO your_table (column1, column2) VALUES (?, ?)', [data.column1, data.column2]);
  await connection.end();

  // Save data to Redis
  await redisClient.set(data.key, JSON.stringify(data));

  // Push data to RabbitMQ
  const connectionMQ = await amqp.connect(rabbitMQUrl);
  const channel = await connectionMQ.createChannel();
  await channel.assertQueue('name');
  await channel.sendToQueue('name', Buffer.from(JSON.stringify(data)));
  await channel.close();
  await connectionMQ.close();

  return {
    statusCode: 200,
    body: JSON.stringify({
      message: 'Data saved and pushed successfully!',
    }),
  };
};
