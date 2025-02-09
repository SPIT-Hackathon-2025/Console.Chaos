import React, { useState, useEffect } from 'react';
import { FaArrowUp, FaArrowDown } from 'react-icons/fa';
import { Line } from 'react-chartjs-2';
import { Chart as ChartJS, LineElement, PointElement, LinearScale, CategoryScale } from 'chart.js';
import axios from 'axios';

ChartJS.register(LineElement, PointElement, LinearScale, CategoryScale);

const issuesData = [
  { id: 1, title: 'Potholes causing traffic congestion', upvotes: 120 },
  { id: 2, title: 'Broken streetlights', upvotes: 95 },
  { id: 3, title: 'Missing road signs', upvotes: 80 },
  { id: 4, title: 'Traffic signal malfunction', upvotes: 60 },
  { id: 5, title: 'Poor road conditions', upvotes: 50 },
];

const StatCard = ({ title, value, change, changeText, icon, borderColor, changeColor }) => (
  <div className={`bg-white rounded-xl p-6 border-l-4 ${borderColor} hover:shadow-xl transition-all duration-300 shadow-sm`}>
    <div className="flex justify-between items-start">
      <div>
        <p className="text-gray-600 text-sm font-medium">{title}</p>
        <h3 className="text-3xl font-bold text-gray-800 mt-1">{value}</h3>
        <div className="flex items-center mt-2">
          {change > 0 ? (
            <FaArrowUp className={`${changeColor} mr-1`} />
          ) : (
            <FaArrowDown className={`${changeColor} mr-1`} />
          )}
          <span className={`${changeColor} text-sm font-medium`}>{Math.abs(change)}%</span>
          <span className="text-gray-500 text-sm ml-2">{changeText}</span>
        </div>
      </div>
      <div className={`${icon.bgColor} p-3 rounded-lg`}>
        <div className={`${icon.textColor} text-2xl`}>{icon.symbol}</div>
      </div>
    </div>
  </div>
);

const TimeFrameButton = ({ active, onClick, children }) => (
  <button
    onClick={onClick}
    className={`px-6 py-2 rounded-lg font-medium transition-all duration-200 ${
      active 
        ? 'bg-blue-600 text-white shadow-md hover:bg-blue-700' 
        : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
    }`}
  >
    {children}
  </button>
);

const FOverview = () => {
    const [timeFrame, setTimeFrame] = useState('daily');
    const [issuesData, setIssuesData] = useState([
      { id: 1, title: 'Potholes causing traffic congestion', upvotes: 120, date: '2025-02-01' },
      { id: 2, title: 'Broken streetlights', upvotes: 95, date: '2025-02-02' },
      { id: 3, title: 'Missing road signs', upvotes: 80, date: '2025-02-03' },
      { id: 4, title: 'Traffic signal malfunction', upvotes: 60, date: '2025-02-04' },
      { id: 5, title: 'Poor road conditions', upvotes: 50, date: '2025-02-05' },
      { id: 6, title: 'Unsafe crossings', upvotes: 140, date: '2025-02-06' },
      { id: 7, title: 'Broken sidewalks', upvotes: 110, date: '2025-02-07' },
      { id: 8, title: 'Missing street lights', upvotes: 125, date: '2025-02-08' },
    ]);
    

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get('https://spit-hacks-two.vercel.app/api/post/');
        console.log(response);
        
        setIssuesData(response.data);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  const chartData = {
    labels: issuesData.map(issue => issue.date),
    datasets: [{
      label: 'Issues Reported',
      data: issuesData.map(issue => issue.upvotes),
      borderColor: '#2563eb',
      backgroundColor: 'rgba(37, 99, 235, 0.1)',
      fill: true,
      tension: 0.4,
      borderWidth: 2,
      pointRadius: 4,
      pointHoverRadius: 6,
    }],
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        display: false,
      },
    },
    scales: {
      x: {
        grid: {
          display: false,
        },
      },
      y: {
        grid: {
          color: 'rgba(0, 0, 0, 0.05)',
        },
      },
    },
  };

  return (
    <div className="p-6 bg-gray-50 min-h-screen">
      <h2 className="text-2xl font-bold text-gray-800 mb-8">Dashboard Overview</h2>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <StatCard
          title="Tasks Closed"
          value="84%"
          change={12.5}
          changeText="from last month"
          icon={{ symbol: '📈', bgColor: 'bg-green-50', textColor: 'text-green-600' }}
          borderColor="border-green-500"
          changeColor="text-green-600"
        />
        <StatCard
          title="Critical Issues"
          value="23"
          change={4.8}
          changeText="needs attention"
          icon={{ symbol: '⚠️', bgColor: 'bg-red-50', textColor: 'text-red-600' }}
          borderColor="border-red-500"
          changeColor="text-red-600"
        />
        <StatCard
          title="Total Issues"
          value="156"
          change={-2.3}
          changeText="this week"
          icon={{ symbol: '📊', bgColor: 'bg-gray-50', textColor: 'text-gray-600' }}
          borderColor="border-gray-400"
          changeColor="text-gray-600"
        />
      </div>

      <div className="flex flex-col lg:flex-row gap-6">
        <div className="lg:w-2/3 bg-white rounded-xl shadow-sm p-6 hover:shadow-lg transition-all duration-300">
          <div className="flex justify-between items-center mb-6">
            <h3 className="text-xl font-bold text-gray-800">Issues Timeline</h3>
            <div className="flex gap-3">
              <TimeFrameButton 
                active={timeFrame === 'daily'} 
                onClick={() => setTimeFrame('daily')}
              >
                Daily
              </TimeFrameButton>
              <TimeFrameButton 
                active={timeFrame === 'monthly'} 
                onClick={() => setTimeFrame('monthly')}
              >
                Monthly
              </TimeFrameButton>
            </div>
          </div>
          <div className="h-80">
            <Line data={chartData} options={chartOptions} />
          </div>
        </div>

        <div className="lg:w-1/3 bg-white rounded-xl shadow-sm p-6 hover:shadow-lg transition-all duration-300">
          <h3 className="text-xl font-bold text-gray-800 mb-6">Top Issues</h3>
          <div className="space-y-4">
            {issuesData.sort((a, b) => b.upvotes - a.upvotes).map((issue, index) => (
              <div 
                key={issue.id} 
                className="flex justify-between items-center p-3 rounded-lg hover:bg-gray-50 transition-colors duration-200"
              >
                <div className="flex items-center gap-3">
                  <span className="text-sm font-medium text-gray-500">#{index + 1}</span>
                  <span className="text-gray-700 font-medium">{issue.title}</span>
                </div>
                <span className="text-gray-600 font-medium">{issue.upvotes} ↑</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default FOverview;