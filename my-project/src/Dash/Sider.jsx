import React from 'react';
import { Link } from 'react-router';
import menu from './menu';

const Sider = () => {
  return (
    <div className="w-16 min-h-screen bg-[#dcd9d9]  py-4 flex flex-col items-center gap-6 justify-center">
      {menu.map((item) => (
        <Link
          key={item.name}
          to={item.link}
          title={item.name}
          className="relative  rounded-lg transition-colors hover:bg-neutral-800 flex items-center justify-center group"
        >
          {React.createElement(item.icon, {
            className: "w-6 h-6 text-neutral-400 group-hover:text-black transition-colors"
          })}
        </Link>
      ))}
    </div>
  );
};

export default Sider;